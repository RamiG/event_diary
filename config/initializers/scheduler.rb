require 'rufus-scheduler'

scheduler = Rufus::Scheduler.singleton
scheduler.cron '00 06 * * *' do
  MailingService.new(User.all, Date.today).notify
end