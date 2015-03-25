module Calendrier
  module CalendrierBuilder

    class Builder
      def initialize(context, options = {})
        @context, @options = context, options
        @options[:display] ||= :month

        unless @options.include? :title
          month = @options[:month] || nil
          year = @options[:year] || nil
          date = (month.nil? || year.nil?) ? Time.now.to_date : Date.new(year, month)
          @options[:title] = "#{I18n.l(date)}"
        end
      end

      def render(&block)
        raise NotImplementedError
      end
    end

    class SimpleBuilder < Builder
      def render(header, content)
        display = @options[:display]
        title = @options[:title] || ''
        cell_date_format = @options[:cell_date_format] || (display == :month ? '%A' : :default)
        time_slot_title = @options[:time_slot_title] || ''

        @context.content_tag(:div, nil, :class => "calendar #{display.to_s}") do
          cal = @context.content_tag(:span, title)
          cal << @context.content_tag(:table, nil) do

            unless header.nil?
              thead = @context.content_tag(:thead, nil) do
                @context.content_tag(:tr, nil) do
                  ths = "".html_safe
                  ths << @context.content_tag(:th, time_slot_title) if display == :week
                  # header.each do |cell_date|
                  #   ths << @context.content_tag(:th,  I18n.l(cell_date, :format => cell_date_format))
                  # end
                  ths
                end
              end
            end

            unless content.nil?
              tbody = @context.content_tag(:tbody, nil) do
                trs = "".html_safe
                content.each_with_index do |row, index|
                  trs << @context.content_tag(:tr, nil) do
                    tds = "".html_safe
                    tds << @context.content_tag(:td, "#{index}h") if display == :week
                    if row.first[:time].nil?
                      starting_missing = row.map{|x| x[:time] }.compact.first.at_beginning_of_week
                      row.each_with_index do |r, index|
                        if r[:time].nil?
                          r[:time] = starting_missing + index.days
                        end
                      end
                    end
                    if row.reverse.first[:time].nil?
                      ending_missing = row.reverse.map{|x| x[:time] }.compact.first.at_end_of_week
                      row.reverse.each_with_index do |r, index|
                        if r[:time].nil?
                          r[:time] = ending_missing - index.days
                        end
                      end
                    end
                    
                    row.collect do |cell|
                      cell_content = "<div class='cell_header'>".html_safe
                      cell_time = cell[:time]
                      cell_content << @context.content_tag(:div, cell_time.day , class: :date_number ) # if display == :month && !cell_time.nil?
                      cell_content <<  @context.content_tag(:div, I18n.l(cell_time, :format => "%A"), class: :weekday) + "</div><div class='events'>".html_safe
                      cell_content << cell[:content]
                      cell_content << '</div>'.html_safe
                      tds << @context.content_tag(:td, cell_content, class: [cell[:time].to_date == Time.now.to_date ? 'today' : '' ,  cell[:time].month != @options[:month] ? "inactive " : (cell[:content].blank? ? "empty" : '')])
                    end
                    tds
                  end
                end
                @context.concat trs
              end
            end

            thead.concat(tbody) unless thead.nil?
          end
          cal
        end
      end
    end

  end
end