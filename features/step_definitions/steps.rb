Then(/^a text message should be sent to "(.*?)" stating "(.*?)"$/) do | expected_phone_number, expected_message_text|
  expect(WebMock).to have_requested(:post, 'https://api.clockworksms.com/xml/send').with { | request | 
    expected_to = "<To>#{expected_phone_number}</To>"
    expected_content = "<Content>#{expected_message_text}</Content>"

    request.body.include?(expected_content) && request.body.include?(expected_to)}
end

