#encoding: utf-8
class Notifier < ActionMailer::Base
  def transaction_to_notification(to,transaction)
    @transaction = transaction
    mail(:from => 'vasyaabr@gmail.com',
    	   :to => to.mail,
         :subject => "Т-Банк : получен банковский перевод",
         :date => Time.now)
  end
  def transaction_from_notification(to,transaction)
    @transaction = transaction
    mail(:from => 'vasyaabr@gmail.com',
    	   :to => to.mail,
         :subject => "Т-Банк : выполнен банковский перевод",
         :date => Time.now)
  end
end
