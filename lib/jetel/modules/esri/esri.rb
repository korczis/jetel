# encoding: utf-8

require_relative '../../modules/module'

module Jetel
  module Modules
    class Esri < Module
      SOURCES = [
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/census/blkgrp.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/census/cd108.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/census/cd109.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/census/cd110.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/census/cd111.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/census/cd112.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/census/cities.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/census/cities_dtl.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/census/counties.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/census/dtl_cnty.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/background/coastal_wtr.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/background/sm_cntry.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/census/places.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/census/states.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/census/dtl_st.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/census/tracts.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/census/urban.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/census/urban_dtl.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/census/zip3.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/census/zip_poly.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/hydro/drainage.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/hydro/hydroln.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/hydro/hydroply.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/hydro/dtl_wat.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/hydro/lakes.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/hydro/rivers.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/hydro/dtl_riv.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/landmarks/fedlandl.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/landmarks/fedlandp.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/landmarks/gblding.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/landmarks/gcemetry.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/landmarks/gchurch.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/landmarks/ggolf.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/landmarks/ghospitl.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/landmarks/glocale.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/landmarks/gppl.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/landmarks/gschools.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/landmarks/gsummit.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/landmarks/quakehis.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/landmarks/volcano.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/other/publdsur.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/other/spcszn27.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/other/spcszn83.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/other/topoq24.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/other/topoq100.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/other/topoq250.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/trans/airports.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/trans/highways.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/trans/intrstat.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/trans/mjr_hwys.zip',
        'http://www.baruch.cuny.edu/geoportal/data/esri/usa/trans/rail100k.zip'
      ]

      def download
        SOURCES.each do |url|
          Downloader.download(url)
        end
      end

      def extract
      end

      def transform
      end

      def load
      end
    end
  end
end
