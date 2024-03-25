class DateValidator < ActiveModel::EachValidator
  DATE_REGEX = /[1-9][0-9][0-9]{2}-([0][1-9]|[1][0-2])-([1-2][0-9]|[0][1-9]|[3][0-1])/

  def validate_each(record, attribute, value)
    return if DATE_REGEX.match?(value.to_s)

    record.errors.add(attribute, (options[:message] || 'format invalid'))
  end
end
