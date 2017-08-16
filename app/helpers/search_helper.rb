module SearchHelper

  def update_params( params, action, key, value = nil )
    p = params.dup
    p.delete(:controller)
    p.delete(:action)
    p.delete(:delete_search)
    add_param( params:p, key: key, value: value ) if action == :add
    remove_param( params:p, key: key, value: value ) if action == :remove
    p[key] = value if action == :update
    p
  end

  # Add filter to search
  def add_param(params:, key:, value: nil)
    if params[key].is_a?(Array)
      params[key] << (value.to_s)
    else
      params[key] = [value.to_s]
    end
  end

  # Removes filter from search
  def remove_param(params:, key:, value: nil)
    if params[key].is_a?(Array)
      params[key].delete(value.to_s)
      params.delete(key) if params[key].empty?
    else
      params.delete(key)
    end
  end

  def search_link( name = nil, param_changes = nil, html_options = nil, &block )

    # Handle the case where param_changes is the first argument (block provided so no name)
    if name.kind_of?( Array )
      html_options = param_changes
      param_changes = name
      name = nil
    end
    html_options = {} if html_options.nil?

    p = params.dup
    param_changes.each do |change|
      p = update_params( p, change[:action], change[:key], change[:value] )
    end
    html_options[:data] = { 'turbolinks-scroll': false }
    if name.nil?
      link_to search_index_path( p ), html_options, &block
    else
      link_to name, search_index_path( p ), html_options, &block
    end
  end

  def review_link( name = nil, param_changes = nil, html_options = nil, &block )

    # Handle the case where param_changes is the first argument (block provided so no name)
    if name.kind_of?( Array )
      html_options = param_changes
      param_changes = name
      name = nil
    end
    html_options = {} if html_options.nil?

    p = params.dup
    param_changes.each do |change|
      p = update_params( p, change[:action], change[:key], change[:value] )
    end
    html_options[:data] = { 'turbolinks-scroll': false }
    if name.nil?
      link_to review_users_path( p ), html_options, &block
    else
      link_to name, review_users_path( p ), html_options, &block
    end
  end

  def photo_link( name = nil, param_changes = nil, html_options = nil, &block )

    # Handle the case where param_changes is the first argument (block provided so no name)
    if name.kind_of?( Array )
      html_options = param_changes
      param_changes = name
      name = nil
    end
    html_options = {} if html_options.nil?

    p = params.dup
    param_changes.each do |change|
      p = update_params( p, change[:action], change[:key], change[:value] )
    end
    html_options[:data] = { 'turbolinks-scroll': false }
    if name.nil?
      link_to photo_users_path( p ), html_options, &block
    else
      link_to name, photo_users_path( p ), html_options, &block
    end
  end

  def video_link( name = nil, param_changes = nil, html_options = nil, &block )

    # Handle the case where param_changes is the first argument (block provided so no name)
    if name.kind_of?( Array )
      html_options = param_changes
      param_changes = name
      name = nil
    end
    html_options = {} if html_options.nil?

    p = params.dup
    param_changes.each do |change|
      p = update_params( p, change[:action], change[:key], change[:value] )
    end
    html_options[:data] = { 'turbolinks-scroll': false }
    if name.nil?
      link_to video_users_path( p ), html_options, &block
    else
      link_to name, video_users_path( p ), html_options, &block
    end
  end

  def param_change( action, key, value = nil )
    { action: action, key: key, value: value }
  end

  def search_company_link( company, params_company_ids, &block )
    params_company_ids ||= []
    if params_company_ids.include?(company.id.to_s)
      param_changes = [param_change( :remove, :companies, company.id.to_s)]
    else
      param_changes = [param_change( :add, :companies, company.id.to_s)]
    end
    search_link param_changes, {}, &block
  end

  def search_category_link( category, params_sub_categories, &block )
    sub_categories_ids = category.sub_categories.ids.map(&:to_s)
    params_sub_categories ||= []
    # Sub categories not selected? add!
    if (sub_categories_ids - params_sub_categories).count == sub_categories_ids.count
      param_changes = sub_categories_ids.map{|id| param_change( :add, :sub_categories, id)}
    else # Sub categories selected? remove all!
      param_changes = []
      sub_categories_ids.each do |id|
        if params_sub_categories.include?(id)
          param_changes << param_change( :remove, :sub_categories, id)
        end
      end
    end
    search_link param_changes, {}, &block
  end

  def search_sub_category_link( sub_category, params_sub_categories, &block )
    if params_sub_categories.is_a?(Array) && params_sub_categories.include?(sub_category.id.to_s)
      param_changes = [param_change( :remove, :sub_categories, sub_category.id.to_s)]
    else
      param_changes = [param_change( :add, :sub_categories, sub_category.id.to_s)]
    end
    search_link nil, param_changes, { class: 'sub-filter-checkbox' }, &block
  end


end
