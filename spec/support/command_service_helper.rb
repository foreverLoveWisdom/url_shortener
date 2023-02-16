# frozen_string_literal: true

# Helper methods for command service specs
module CommandServiceHelper
  def command_service_error
    context.errors.full_messages.to_sentence
  end
end
