# frozen_string_literal: true

module Plutto
  # A handful of run-of-the-mill utilities
  module Utils
    extend self

    # If the key exists, you will get that key-value pair.
    #
    # @param dict_ [Hash] the hash to pick from
    # @param key [String] the key to look at
    # @return [Hash] the key-value pair or an empty hash
    def pick(dict_, key)
      key = key.to_sym
      if dict_.key?(key)
        { "#{key}": dict_[key] }
      else
        {}
      end
    end

    # Transform a snake-cased name to its pascal-cased version.
    #
    # @param name [String]
    # @return [String]
    def snake_to_pascal(name)
      name.split(/_| /).map(&:capitalize).join('')
    end
  end
end
