class Formtastic::Inputs::GroupedCheckBoxesInput < Formtastic::Inputs::CheckBoxesInput

  def to_html
    raise "Hash required!" unless Hash === grouped_collection = options[:collection]
    return unless sample_collection = grouped_collection.first&.second
    @label_and_value_method = label_and_value_method_from_collection sample_collection

    result = input_wrapping do
      choices_wrapping do
        legend_html <<
        hidden_field_for_all <<
        grouped_collection.keys.map do |group|

          @raw_collection = grouped_collection[group]

          template.content_tag(:ol, template.content_tag(:li,
            template.content_tag(:label, group.name))) <<

          choices_group_wrapping do
            # template.content_tag(:li, template.content_tag(:label, group.name)) <<
            collection.map do |choice|
              choice_wrapping(choice_wrapping_html_options choice) do
                choice_html(choice)
              end
            end.join("\n").html_safe
          end

        end.join("\n").html_safe
      end
    end
    @raw_collection = nil # reset it to pristine state just in case
    result
  end

end
