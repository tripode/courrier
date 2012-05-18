class EmailSender < ActionMailer::Base
  default from: "ds.representaciones.py@gmail.com"
  
  ##
  # Este metodo es el encargado de preparar los destinatarios, asunto y adjuntos.
  #
  def eemail(email, file_path) 
    puts "llega al email sender"
    puts email
    puts file_path
    attachments["testeeeeee.pdf"] = File.read(file_path)
    mail(:to => email, :subject => 'Informe') do |format|
      format.text do
        render :text => 'Este es un test de envio de email'
      end
    end 
  end
  
  
end
