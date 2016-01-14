# -*- encoding : utf-8 -*-
I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
I18n.default_locale = :en
I18n.available_locales = [:en, :et, :fi, :ru, :sv]

I18n.fallbacks[:en] = [:en, :et, :fi, :ru, :sv] 
I18n.fallbacks[:sv] = [:sv, :en, :fi, :et, :ru]
I18n.fallbacks[:et] = [:et, :en, :ru, :fi, :sv]
I18n.fallbacks[:fi] = [:fi, :en, :sv, :et, :ru]
I18n.fallbacks[:ru] = [:ru, :en, :et, :fi, :sv]
I18n.fallbacks[:lv] = [:ru, :en, :et ]

Globalize.fallbacks = {:en => [:en, :et, :fi, :ru, :sv] , :fi => [:fi, :sv, :en, :et, :ru],
  et: [:et, :en, :ru, :fi, :sv], sv:  [:sv, :fi, :en, :et, :ru], ru:[:ru, :en, :et, :fi, :sv],
   lv: [:ru, :en, :et ] }
I18n.enforce_available_locales = false