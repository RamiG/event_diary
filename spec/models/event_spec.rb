require 'rails_helper'

describe Event do
  let(:event) { FactoryGirl.create(:event) }

  subject { event }

  it { should be_valid }

  it { should respond_to(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:starts_on) }
  it { should enumerize(:repeats).in(*Event::REPEAT_TYPES) }

  describe 'repeats' do
    context 'recurring' do
      before { subject.recurring = true }
      it { should validate_presence_of(:repeats) }
    end

    context 'not recurring' do
      before { subject.recurring = false }
      it { should_not validate_presence_of(:repeats) }
    end
  end

  describe '#as_json' do
    let(:expected_result) do
      {
        id: event.id,
        title: event.title,
        start: event.starts_on
      }
    end

    its(:as_json) { should eq(expected_result) }
  end
end