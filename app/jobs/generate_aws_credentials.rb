class GenerateAWSCredentials < ActiveJob::Base
  def perform(user)
    iam_user = iam.users.create(user.email)
    group.add iam_user
    user.update_attributes aws: {
      access_key_id: iam_user.aws_access_key_id
      secret_access_key: iam_user.aws_secret_access_key
    }
  end

  private
  def group
    iam.groups.find('waxpoetic_users') || iam.groups.create('waxpoetic_users')
  end

  def iam
    @iam ||= AWS::IAM.new
  end
end
