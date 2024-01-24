# spec/integration/goals_spec.rb
require 'swagger_helper'

RSpec.describe Api::Goals::DoneController, type: :request, skip: true do
  base_path = '/api/goals/done'

  path "#{base_path}/index" do
    post 'A goal as done' do
      tags 'Goals'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :goal, in: :body, schema: {
        type: :object,
        properties: {
          goal_id: { type: :integer }
        },
        required: ['goal_id']
      }
      before do
        @goal = create(:goal, :with_tasks)
      end

      response '200', 'goal marked as done' do
        let(:goal) { { goal_id: @goal.id } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['status']).to eq('done')
          expect(response).to match_response_schema('goal')
        end
      end

      response '404', 'goal not found' do
        let(:goal) { { goal_id: 'invalid' } }
        run_test!
      end
    end
  end

  path "#{base_path}/show" do
    post 'A goal as done' do
      tags 'Goals'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :goal, in: :body, schema: {
        type: :object,
        properties: {
          goal_id: { type: :integer }
        },
        required: ['goal_id']
      }
      before do
        @goal = create(:goal, :with_tasks)
      end

      response '200', 'goal marked as done' do
        let(:goal) { { goal_id: @goal.id } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['status']).to eq('done')
          expect(response).to match_response_schema('goal')
        end
      end

      response '404', 'goal not found' do
        let(:goal) { { goal_id: 'invalid' } }
        run_test!
      end
    end
  end

  path "#{base_path}/many" do
    post 'A goals as done' do
      tags 'Goals'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :goal, in: :body, schema: {
        type: :object,
        properties: {
          goal_ids: { type: :array, items: { type: :integer } }
        },
        required: ['goal_ids']
      }
      before do
        @goals = create_list(:goal, 3, :with_tasks)
      end

      response '200', 'goals marked as done' do
        let(:goal) { { goal_ids: @goals.pluck(:id) } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data[1]['status']).to eq('done')
          expect(response).to match_response_schema('goals')
        end
      end

      response '404', 'goals not found' do
        let(:goal) { { goal_ids: 'invalid' } }
        run_test!
      end
    end
  end
end
