# spec/support/request_spec_helper.rb
module RequestSpecHelper
    # Parse JSON response body to ruby hash
    def json
        JSON.parse(response.body)
    end
end