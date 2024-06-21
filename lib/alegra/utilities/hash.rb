# frozen_string_literal: true

class Hash
  def deep_camel_case_lower_keys(hash = self)
    {}.tap do |h|
      hash.each { |key, value| h[camel_case_lower_key(key)] = map_value(value, :deep_camel_case_lower_keys) }
    end
  end

  def deep_underscore_keys(hash = self)
    {}.tap do |h|
      hash.each { |key, value| h[underscore_key(key)] = map_value(value, :deep_underscore_keys) }
    end
  end

  private

  def underscore_key(key)
    key.to_s.underscore.to_sym
  end

  def camel_case_lower_key(key)
    key.to_s.split('_').inject([]) { |buffer, e| buffer.push(buffer.empty? ? e : e.capitalize) }.join.to_sym
  end

  def map_value(thing, method)
    case thing
    when Hash
      __send__(method, thing)
    when Array
      thing.map { |v| map_value(v, method) }
    else
      thing
    end
  end
end
