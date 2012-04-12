require 'spec_helper'

describe Census::User do
  before do
    Census::DataType.define("String")

    Census::DataType.define(
      "Number",
      :sql_transform  => lambda {|column_name| "CAST(#{column_name} AS SIGNED INTEGER)"},
      :format_data    => lambda {|data| data.to_i unless data.blank? },
      :validate_data  => lambda {|data| "must be a number" unless data =~ /^\d*$/}
    )
    @user = FactoryGirl.create(:user_with_answers)
  end

  # == CONSTANTS == #
  # == ASSOCIATIONS == #
  # == ACCESSIBILITY == #
  # == SCOPES == #
  # == VALIDATIONS == #
  # == CALLBACKS == #
  # == CLASS METHODS == #
  # == INSTANCE METHODS == #
  context "Instance Methods:" do
    describe "#first_answer_for(question)" do
      it "Returns this user's first answer for the given question, or a new empty answer if the user has not answered the question." do
        puts YAML::dump(@user.answers)
        @user.first_answer_for(@question3).should == "Blue"
      end
    end
  end

end