using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Threading;
using System.Threading.Tasks;
using System.Web.Services.Description;
using FluentEmail.Core;
using FluentEmail.Core.Interfaces;
using FluentEmail.Core.Models;
using FluentEmail.Smtp;

namespace Email_service.Mailtrap
{
    /// <summary>
    /// Send emails to a Mailtrap.io inbox
    /// </summary>
    public class MailtrapSender : ISender, IDisposable
    {
        private readonly SmtpClient _smtpClient;


        /// <summary>
        /// Creates a sender that uses the given Mailtrap credentials, but does not dispose it.
        /// </summary>
        string port = System.Web.Configuration.WebConfigurationManager.AppSettings["email_port"];
        string host = System.Web.Configuration.WebConfigurationManager.AppSettings["email_host"];
        string username = System.Web.Configuration.WebConfigurationManager.AppSettings["email_username"];
        string password = System.Web.Configuration.WebConfigurationManager.AppSettings["email_password"];
        public MailtrapSender()
        {
            int smtp_port = 2525;
            try {
               smtp_port=Int32.Parse(port);

                _smtpClient = new SmtpClient(host, smtp_port)
                {
                    Credentials = new NetworkCredential(username, password),
                    EnableSsl = true
                };
            }
            catch {
                Console.WriteLine($"Unable to parse '{port}'");
            }
           
        }

        public void Dispose() => _smtpClient?.Dispose();

        public SendResponse Send(IFluentEmail email, CancellationToken? token = null)
        {
            var smtpSender = new SmtpSender(_smtpClient);
            return smtpSender.Send(email, token);
        }

        public Task<SendResponse> SendAsync(IFluentEmail email, CancellationToken? token = null)
        {
            var smtpSender = new SmtpSender(_smtpClient);
            return smtpSender.SendAsync(email, token);
        }
    }
}


