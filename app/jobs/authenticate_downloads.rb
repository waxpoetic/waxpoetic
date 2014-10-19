class AuthenticateDownloads < ActiveJob::Base
  def perform(order)
    iam = AWS::IAM.new user.aws
    order.products.each do |product|
      downloadable = resource_for(product)

      policy = AWS::S3::Policy.new

      policy.allow(
        actions: ['s3:GetObject'],
        resources: "arn:aws:s3:::#{bucket}/#{downloadable.file.path}"
        principals: user
      )
    end
  end
end
