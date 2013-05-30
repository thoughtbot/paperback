Then /^the following files should exist on S3:$/ do |files|
  bucket = AWS::S3.new.buckets[ENV['AWS_BUCKET']]
  files.raw.map(&:first).each do |file_name|
    expect(bucket.objects[file_name]).to exist
  end
end
