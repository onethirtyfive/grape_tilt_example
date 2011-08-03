Tilt & Grape
============

Overview
--------

Some people have asked for Grape to integrate with Tilt.

This implementation does that, with some limitations:

- the view has only one object: locals[:object]
- you must 'use Rack::Config' in your config.ru to
  configure the view template root


