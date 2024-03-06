require 'swagger_helper'

RSpec.describe 'api/v1/type_tickets', type: :request do

  path '/api/v1/type_tickets' do
    get('list all type tickets') do
      tags 'Api::V1::TypeTickets'
      produces 'application/json'

      response '200', 'type tickets' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              description: { type: :text },
              value: { type: :float },
              created_at: { type: :string},
              updated_at: { type: :string}
            }
          }
        run_test!
      end
    end

    post 'Create type ticket' do
      tags 'Api::V1::TypeTickets'
      consumes 'application/json'
      parameter name: :type_ticket, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :text },
          value: { type: :float }
        },
        required: [ 'name', 'value' ]
      }

      response('201', 'Type Ticket created') do
        let(:type_ticket) { { name: 'Type Tickets', description: 'description ...', value: 100.0 } }
        run_test!
      end

      response('422', 'invalid request') do
        let(:type_ticket) { { name: 'Type Tickets'} }
        run_test!
      end
    end
  end

  path '/api/v1/type_tickets/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show ticket') do
      tags 'Api::V1::TypeTickets'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response('200', 'type ticket found')do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            description: { type: :text },
            value: { type: :float },
            created_at: { type: :string},
            updated_at: { type: :string}
          },
          required: [ 'id', 'name', 'value' ]

        let(:id) { TypeTicket.create(name: 'Type Tickets', description: 'description ...', value: 100.0).id }
        run_test!
      end

      response('404', 'type ticket not found') do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    patch('update type_ticket') do
      tags 'Api::V1::TypeTickets'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string,
      required: [ 'id' ]
      parameter name: :type_ticket, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :text },
          value: { type: :float }
        }
      }

      response('200', 'Type Ticket updated') do
        let(:id) { TypeTicket.create(name: 'Type Tickets', description: 'description ...', value: 100.0).id }
        let(:type_ticket) { { name: 'Type Tickets', description: 'description ...', value: 100.0 } }
        run_test!
      end

      response('422', 'invalid request') do
        let(:id) { TypeTicket.create(name: 'Type Tickets', description: 'description ...', value: 100.0).id }
        let(:type_ticket) { { name: ''} }
        run_test!
      end

      response('404', 'type ticket not found') do
        let(:id) { 'invalid' }
        let(:type_ticket) { { name: 'Type Tickets', description: 'description ...', value: 100.0 } }
        run_test!
      end
    end

    put('update type_ticket') do
      tags 'Api::V1::TypeTickets'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :type_ticket, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :text },
          value: { type: :float }
        }
      }

      response('200', 'Type Ticket updated') do
        let(:id) { TypeTicket.create(name: 'Type Tickets', description: 'description ...', value: 100.0).id }
        let(:type_ticket) { { name: 'Type Tickets', description: 'description ...', value: 100.0 } }
        run_test!
      end

      response('422', 'invalid request') do
        let(:id) { TypeTicket.create(name: 'Type Tickets', description: 'description ...', value: 100.0).id }
        let(:type_ticket) { { name: ''} }
        run_test!
      end

      response('404', 'type ticket not found') do
        let(:id) { 'invalid' }
        let(:type_ticket) { { name: 'Type Tickets', description: 'description ...', value: 100.0 } }
        run_test!
      end
    end

    delete('delete type_ticket') do
      tags 'Api::V1::TypeTickets'
      parameter name: :id, in: :path, type: :string

      response(204, 'deleted') do
        let(:id) { TypeTicket.create(name: 'Type Tickets', description: 'description ...', value: 100.0).id }
        run_test!
      end

      response('404', 'type ticket not found') do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
