module TestValidations
  def test_validations_with(required_attrs)
    required_attrs.each do |attr|
      it "must have :#{attr} set" do
        subject.send "#{attr}=", nil
        expect(subject).to_not be_valid
      end
    end
  end
end
