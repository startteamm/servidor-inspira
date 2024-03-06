require 'swagger_helper'

RSpec.describe 'api/v1/tickets', type: :request do

  path '/api/v1/tickets' do
    get('list all Tickets') do
      tags 'Api::V1::Tickets'
      produces 'application/json'

      response '200', 'Tickets' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :string },
              code: { type: :string },
              validated: { type: :text },
              created_at: { type: :string},
              updated_at: { type: :string},
              type_ticket_id: { type: :integer }
            }
          }
        run_test!
      end
    end

    post 'Create Ticket' do
      tags 'Api::V1::Tickets'
      consumes 'application/json'
      parameter name: :ticket, in: :body, schema: {
        type: :object,
        properties: {
          type_ticket_id: { type: :integer }
        },
        required: [ 'type_ticket_id' ]
      }

      response('201', 'Ticket created') do
        let(:ticket) { { type_ticket_id: TypeTicket.create(name: 'Ticket', value: 1.0).id  } }
        run_test!
      end

      response('422', 'invalid request') do
        let(:ticket) { }
        run_test!
      end
    end
  end

  path '/api/v1/tickets/{id}' do
    get('show ticket') do
      tags 'Api::V1::Tickets'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response('200', 'Ticket found')do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            description: { type: :text },
            value: { type: :float },
            created_at: { type: :string},
            updated_at: { type: :string}
          }

        let(:type_ticket) { TypeTicket.create(name: 'Ticket1', value: 1.0) }
        let(:id) { Ticket.create(type_ticket_id: type_ticket.id).id }
        run_test!
      end

      response('404', 'Ticket not found') do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    patch('update ticket') do
      tags 'Api::V1::Tickets'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string,
      required: [ 'id' ]
      parameter name: :ticket, in: :body, schema: {
        type: :object,
        properties: {
          type_ticket_id: { type: :integer }
        }
      }

      response('200', 'Ticket updated') do
        let(:type_ticket) { TypeTicket.create(name: 'Ticket2', value: 20.0) }
        let(:id) { Ticket.create(type_ticket_id: type_ticket.id).id }
        let(:ticket) { { value: 40.0 } }
        run_test!
      end

      response('422', 'invalid request') do
        let(:type_ticket) { TypeTicket.create(name: 'Ticket3', value: 20.0) }
        let(:id) { Ticket.create(type_ticket_id: type_ticket.id).id }
        let(:ticket) { { type_ticket_id: '' } }
        run_test!
      end

      response('404', 'Ticket not found') do
        let(:id) { 'invalid' }
        let(:ticket) { }
        run_test!
      end
    end

    put('update ticket') do
      tags 'Api::V1::Tickets'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string,
      required: [ 'id' ]
      parameter name: :ticket, in: :body, schema: {
        type: :object,
        properties: {
          type_ticket_id: { type: :integer }
        }
      }

      response('200', 'Ticket updated') do
        let(:type_ticket) { TypeTicket.create(name: 'Ticket4', value: 20.0) }
        let(:id) { Ticket.create(type_ticket_id: type_ticket.id).id }
        let(:ticket) { { value: 40.0 } }
        run_test!
      end

      response('422', 'invalid request') do
        let(:type_ticket) { TypeTicket.create(name: 'Ticket5', value: 20.0) }
        let(:id) { Ticket.create(type_ticket_id: type_ticket.id).id }
        let(:ticket) { { type_ticket_id: '' } }
        run_test!
      end

      response('404', 'Ticket not found') do
        let(:id) { 'invalid' }
        let(:ticket) { }
        run_test!
      end
    end

    delete('delete ticket') do
      tags 'Api::V1::Tickets'
      parameter name: :id, in: :path, type: :string

      response('204', 'deleted') do
        let(:type_ticket) { TypeTicket.create(name: 'Ticket6', value: 1.0) }
        let(:id) { Ticket.create(type_ticket_id: type_ticket.id).id }
        run_test!
      end

      response('404', 'Ticket not found') do
        let(:id) { 'invalid' }
        let(:ticket) { }
        run_test!
      end
    end
  end
end
