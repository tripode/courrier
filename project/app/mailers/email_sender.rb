class EmailSender < ActionMailer::Base
  default from: "ds.representaciones.py@gmail.com"
  
  ##
  # Este metodo es el encargado de preparar los destinatarios, asunto y adjuntos.
  #
  def send_email(customer) 
    attachments["testeeeeee.pdf"] = File.read("C:/test.pdf")
    mail(:to => customer.email, :subject => 'Informe') do |format|
      format.text do
        render :text => 'Este es un test de envio de email'
      end
    end 
  end
  
  
end
