Then(/^a text message with following content should be sent:$/) do |expected_body|
  expect(WebMock).to have_requested(:post, 'https://api.clockworksms.com/xml/send').with { | request | 
    request.body.include?('<Content>It is 62.7 degrees and Mostly Cloudy</Content>') && request.body.include?('<To>07590389430</To>')}

end
