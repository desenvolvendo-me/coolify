class CftValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless technical_lead?(record) && value.blank?

    record.errors.add(attribute, :blank)
  end

  private

  def technical_lead?(user)
    user.role == 'technical_lead'
  end
end
