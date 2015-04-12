require 'rails_helper'

RSpec.describe EventsController, :type => :controller do
  let(:event) { events :come_correct }
  let(:admin) { users :admin }
  let :new_event_attributes do
    {
      name: "Wyld Lyfe",
      ticket_price: 25.00,
      starts_at: 3.days.from_now.to_datetime,
      location: "Philadelphia, PA"
    }
  end

  context "when signed in" do
    before { sign_in admin }

    it "renders the new form" do
      get :new
      expect(response).to be_success
    end

    it "renders the edit form" do
      get :edit, id: event.id
      expect(response).to be_success
    end

    it "creates an event" do
      post :create, event: new_event_attributes
      expect(controller.event).to be_valid
      expect(controller.event).to be_persisted
      expect(response).to be_redirect
      expect(response).to redirect_to(controller.event)
    end

    it "updates an event" do
      put :update, id: event.id, event: { name: "Come Correct II" }
      expect(controller.event).to be_valid
      expect(controller.event.name).to eq("Come Correct II")
      expect(response).to be_redirect
      expect(response).to redirect_to("http://test.host/events/come-correct-ii")
    end

    it "destroys an event" do
      delete :destroy, id: event.id
      expect(response).to be_redirect
      expect(response).to redirect_to(events_path)
    end
  end

  context "when not signed in" do
    it "views all events" do
      get :index
      expect(response).to be_success
      expect(controller.events).to_not be_empty
    end

    it "searches events" do
      get :index, name: event.name
      expect(response).to be_success
      expect(controller.events).to include(event)
    end

    it "views a single event" do
      get :show, id: event.id
      expect(response).to be_success
      expect(controller.event).to eq(event)
    end

    it "cannot view the new form" do
      get :new
      expect(response).to be_redirect
      expect(response).to redirect_to(new_user_session_path)
    end

    it "cannot view the edit form" do
      get :edit, id: event.id
      expect(response).to be_redirect
      expect(response).to redirect_to(new_user_session_path)
    end

    it "cannot create an event" do
      post :create, event: new_event_attributes
      expect(response).to be_redirect
      expect(response).to redirect_to(new_user_session_path)
    end

    it "cannot update an event" do
      put :update, id: event.id, event: { name: 'nope' }
      expect(response).to be_redirect
      expect(response).to redirect_to(new_user_session_path)
    end

    it "cannot destroy an event" do
      delete :destroy, id: event.id
      expect(response).to be_redirect
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
