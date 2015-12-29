# -*- encoding : utf-8 -*-
I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
I18n.default_locale = :en
I18n.available_locales = [:en, :et, :fi, :ru, 'sv-SE']
I18n.fallbacks[:en] = [:en, :et, :fi, :ru, 'sv-SE'] 
I18n.fallbacks['sv-SE'] = ['sv-SE', :fi, :en, :et, :ru]
I18n.fallbacks[:et] = [:et, :en, :ru, :fi, 'sv-SE']
I18n.fallbacks[:fi] = [:fi, 'sv-SE', :en, :et, :ru]
I18n.fallbacks[:ru] = [:ru, :en, :et, :fi, 'sv-SE']
I18n.fallbacks[:lv] = [:ru, :en, :et ]

Globalize.fallbacks = {:en => [:en, :et, :fi, :ru, 'sv-SE'] , :fi => [:fi, 'sv-SE', :en, :et, :ru],
  et: [:et, :en, :ru, :fi, 'sv-SE'], 'sv-SE':  ['sv-SE', :fi, :en, :et, :ru], ru:[:ru, :en, :et, :fi, 'sv-SE'],
   lv: [:ru, :en, :et ] }
I18n.enforce_available_locales = false