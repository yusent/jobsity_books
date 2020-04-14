class ApplicationController < ActionController::API
  private
    def paginate(records)
      page = params.fetch(:page, 1).to_i
      per_page = params.fetch(:per_page, 100).to_i
      count = records.model.count

      render json: {
        records.table_name => records.limit(per_page).offset(page - 1),
        meta: {
          per_page: per_page,
          page: page,
          total_pages: (count / per_page.to_f).ceil,
          total_objects: count,
        },
      }
    end
end
