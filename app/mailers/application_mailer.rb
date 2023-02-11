# frozen_string_literal: true

# Application Mailer Settings
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
