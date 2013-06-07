def bucket
  AWS::S3.new.buckets[ENV['AWS_BUCKET']]
end

Then /^the following files should exist on S3:$/ do |files|
  files.raw.map(&:first).each do |file_name|
    expect(bucket.objects[file_name]).to exist
  end
end

Then /^"(.*?)" should have the mime-type "(.*?)" on S3$/ do |file_name, mime_type|
  expect(bucket.objects[file_name].content_type).to eq(mime_type)
end
