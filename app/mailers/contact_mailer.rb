class ContactMailer < ActionMailer::Base

  def new_contact(contact)
    @contact = contact
    mail(to: APP_CONFIG['admin_email'], from: "#{@contact.name} <#{@contact.email}>", subject: 'DBJohn.com contact form submission')
  end
end
