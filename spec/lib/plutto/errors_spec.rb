require 'plutto/errors'

RSpec.describe Plutto::Errors do
  let(:error) do
    {
      message: 'No valid API key provided.',
      doc_url: 'https://docs.plutto.com/'
    }
  end

  it 'raises a Unauthorized Error' do
    expect { raise Plutto::Errors::UnauthorizedError.new(error[:message], error[:doc_url]) }
      .to(raise_error(an_instance_of(Plutto::Errors::UnauthorizedError))
      .with_message(/No valid API key provided/))
  end

  it 'raises a Unauthorized Error with default url doc' do
    expect { raise Plutto::Errors::UnauthorizedError.new(error[:message]) }
      .to(raise_error(an_instance_of(Plutto::Errors::UnauthorizedError))
      .with_message(%r{https://docs.getplutto.com/}))
  end
end
