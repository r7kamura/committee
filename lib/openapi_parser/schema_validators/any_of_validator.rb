class OpenAPIParser::SchemaValidator
  class AnyOfValidator < Base
    # @param [Object] value
    # @param [OpenAPIParser::Schemas::Schema] schema
    def coerce_and_validate(value, schema)
      # in all schema return error (=true) not any of data
      schema.any_of.each do |s|
        coerced, err = validatable.validate_schema(value, s)
        return [coerced, nil] if err.nil?
      end
      [nil, OpenAPIParser::NotAnyOf.new(value, schema.object_reference)]
    end
  end
end