require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :request do
  content_type = "application/json; charset=utf-8"

  let(:model) { build :book }
  let(:valid_attributes) { { book: build(:book).attributes } }
  let(:invalid_attributes) { { book: Book.new.attributes } }

  describe "GET /index" do
    it "renders a successful response" do
      get api_v1_books_url, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      model.save
      get api_v1_book_url(model), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new book" do
        expect do
          post api_v1_books_url, params: valid_attributes, as: :json
        end.to change(Book, :count).by(1)
      end

      it "renders a JSON response with the new book" do
        post api_v1_books_url, params: valid_attributes, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including(content_type))
      end
    end

    context "with invalid parameters" do
      it "does not create a new book" do
        expect { post api_v1_books_url, params: invalid_attributes, as: :json }
          .to change(Book, :count).by(0)
      end

      it "renders a JSON response with errors for the new book" do
        post api_v1_books_url, params: invalid_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including(content_type))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      it "updates the requested book" do
        model.save
        prev_updated_at = model.updated_at
        patch api_v1_book_url(model), params: valid_attributes, as: :json
        model.reload
        expect(model.updated_at).to_not eq(prev_updated_at)
      end

      it "renders a JSON response with the book" do
        model.save
        patch api_v1_book_url(model), params: valid_attributes, as: :json
        expect(response).to be_successful
        expect(response.content_type).to match(a_string_including(content_type))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the api/v1_book" do
        model.save
        patch api_v1_book_url(model), params: invalid_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including(content_type))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested api/v1_book" do
      model.save
      expect { delete api_v1_book_url(model), as: :json }
        .to change(Book, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
