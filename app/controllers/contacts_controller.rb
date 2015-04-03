class ContactsController < ApplicationController

  def new
    @contact = Contact.new
    @contact.textcaptcha
    @page = Page.find_by_permalink('contact') || Page.new(title: 'Contact', permalink: 'contact', content: 'Enter some content here...')
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.valid?
      ContactMailer.new_contact(@contact).deliver_now
      redirect_to root_path, notice: "Thanks for your message."
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:textcaptcha_answer, :textcaptcha_key, :name, :email, :message)
  end
end
