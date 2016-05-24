class UserMailer < ApplicationMailer
  def confirmation_instructions(record, token, opts={})
    headers["Custom-header"] = "Bar"
    opts[:subject] = 'sheep0406@hotmail.com'
    opts[:from] = 'sheep0406@hotmail.com'
    opts[:reply_to] = 'sheep0406@hotmail.com'
    super
  end
end
