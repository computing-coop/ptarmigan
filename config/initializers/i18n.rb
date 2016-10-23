# -*- encoding : utf-8 -*-
I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
I18n.default_locale = :en
I18n.available_locales = [:en, :et, :fi, :ru, :sv, :lv]

# I18n.fallbacks[:en] = [:en, :et, :fi, :ru, :sv, :lv]
# I18n.fallbacks[:sv] = [:sv, :en, :fi, :et, :ru, :lv]
# I18n.fallbacks[:et] = [:et, :en, :ru, :fi, :sv, :lv]
# I18n.fallbacks[:fi] = [:fi, :en, :sv, :et, :ru, :lv]
# I18n.fallbacks[:ru] = [:ru, :en, :lv, :et, :fi, :sv]
# I18n.fallbacks[:lv] = [:lv, :en, :ru, :et]

Globalize.fallbacks = {:en => [:en, :et, :fi, :ru, :sv, :lv] , :fi => [:fi, :sv, :en, :et, :ru, :lv],
  et: [:et, :en, :ru, :fi, :sv, :lv], sv:  [:sv, :fi, :en, :et, :ru, :lv], ru:[:ru, :en, :et, :lv, :fi, :sv],
   lv: [:lv, :en, :ru, :et ] }
   
I18n.enforce_available_locales = false
