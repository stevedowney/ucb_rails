# Base class for server-side processing for datatable.js
#
# Inspired by http://railscasts.com/episodes/340-datatables
#
# Documentation on datatable.js parameters: http://datatables.net/usage/server-side
#
# class MyUsersController <  BaseController
# 
#   def index
#     respond_to do |format|
#       format.html
#       format.json { render json: MyUsersDatatable.new(view_context) }
#     end
#   end
#   
# end
# 
# class MyUserDatatable < BaseDatatable
# 
#   private
# 
#   def default_scope
#     User
#   end
#   
#   def column_names
#     @column_names ||= %w[first_name last_name]
#   end
#   
#   # Must return valid argument(s) to ActiveRecord::Relation#where()
#   # (Won't be called if _search_term_ is blank)
#   def search(search_term)
#     where("first_name like :search or last_name like :search", search: "#{search_term}%")
#   end
#   
#   def record_to_data(user)
#     [
#       h(user.first_name),
#       h(user.last_name),
#       link_to("Edit", edit_admin_user_path(user), :id => dom_id(user)),
#     ]
#   end
# 
# end
#
class UcbRails::BaseDatatable
  
  def initialize(view)
    @view = view
  end

  # Data structure required by datatable.js server calls
  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: default_scope.count,
      iTotalDisplayRecords: records.total_count,
      aaData: data
    }
  end

  private

  # Returns Array of Array.
  def data
    @data ||= records.map { |record| record_to_data(record) }
  end
  
  # Returns ActiveRecord::Relation
  def records
    @records ||= default_scope
      .where(base_search)
      .order(order)
      .page(page)
      .per(per)
  end
  
  def base_search
    search_term = params[:sSearch]
    
    if search_term.present?
      search(search_term)
    else
      {}
    end
  end

  def per
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def page
    params[:iDisplayStart].to_i/per + 1
  end
  
  def order
    order_clauses.join(', ')
  end
  
  def order_clauses
    (0...params['iSortingCols'].to_i).map { |i| order_clause(i) }
  end
  
  def order_clause(i)
    column_key = "iSortCol_#{i}"
    direction_key = "sSortDir_#{i}"
    "#{column_names[params[column_key].to_i]} #{params[direction_key]}"
  end

  # Delegate unknown methods to the view.  These are mostly standard View Helper methods.
  def method_missing(*args, &block)
    @view.send(*args, &block)
  end
  
end