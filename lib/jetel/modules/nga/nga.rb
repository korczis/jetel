# encoding: utf-8

require 'pmap'

require_relative '../../modules/module'

module Jetel
  module Modules
    class Nga < Module
      SOURCES = [
        {
          name: 'AFGHANISTAN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/af.zip'
        },
        {
          name: 'AKROTIRI',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ax.zip'
        },
        {
          name: 'ALBANIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/al.zip'
        },
        {
          name: 'ALGERIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ag.zip'
        },
        {
          name: 'ANDORRA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/an.zip'
        },
        {
          name: 'ANGOLA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ao.zip'
        },
        {
          name: 'ANGUILLA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/av.zip'
        },
        {
          name: 'ANTIGUA AND BARBUDA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ac.zip'
        },
        {
          name: 'ARGENTINA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ar.zip'
        },
        {
          name: 'ARMENIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/am.zip'
        },
        {
          name: 'ARUBA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/aa.zip'
        },
        {
          name: 'ASHMORE AND CARTIER ISLANDS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/at.zip'
        },
        {
          name: 'AUSTRALIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/as.zip'
        },
        {
          name: 'AUSTRIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/au.zip'
        },
        {
          name: 'AZERBAIJAN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/aj.zip'
        },
        {
          name: 'BAHAMAS, THE',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/bf.zip'
        },
        {
          name: 'BAHRAIN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ba.zip'
        },
        {
          name: 'BANGLADESH',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/bg.zip'
        },
        {
          name: 'BARBADOS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/bb.zip'
        },
        {
          name: 'BASSAS DA INDIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/bs.zip'
        },
        {
          name: 'BELARUS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/bo.zip'
        },
        {
          name: 'BELGIUM',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/be.zip'
        },
        {
          name: 'BELIZE',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/bh.zip'
        },
        {
          name: 'BENIN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/bn.zip'
        },
        {
          name: 'BERMUDA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/bd.zip'
        },
        {
          name: 'BHUTAN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/bt.zip'
        },
        {
          name: 'BOLIVIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/bl.zip'
        },
        {
          name: 'BOSNIA AND HERZEGOVINA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/bk.zip'
        },
        {
          name: 'BOTSWANA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/bc.zip'
        },
        {
          name: 'BOUVET ISLAND',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/bv.zip'
        },
        {
          name: 'BRAZIL',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/br.zip'
        },
        {
          name: 'BRITISH INDIAN OCEAN TERRITORY',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/io.zip'
        },
        {
          name: 'BRITISH VIRGIN ISLANDS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/vi.zip'
        },
        {
          name: 'BRUNEI',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/bx.zip'
        },
        {
          name: 'BULGARIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/bu.zip'
        },
        {
          name: 'BURKINA FASO',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/uv.zip'
        },
        {
          name: 'BURMA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/bm.zip'
        },
        {
          name: 'BURUNDI',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/by.zip'
        },
        {
          name: 'CAMBODIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/cb.zip'
        },
        {
          name: 'CAMEROON',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/cm.zip'
        },
        {
          name: 'CANADA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ca.zip'
        },
        {
          name: 'CABO VERDE',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/cv.zip'
        },
        {
          name: 'CAYMAN ISLANDS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/cj.zip'
        },
        {
          name: 'CENTRAL AFRICAN REPUBLIC',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ct.zip'
        },
        {
          name: 'CHAD',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/cd.zip'
        },
        {
          name: 'CHILE',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ci.zip'
        },
        {
          name: 'CHINA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ch.zip'
        },
        {
          name: 'CHRISTMAS ISLAND',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/kt.zip'
        },
        {
          name: 'CLIPPERTON ISLAND',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ip.zip'
        },
        {
          name: 'COCOS (KEELING) ISLANDS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ck.zip'
        },
        {
          name: 'COLOMBIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/co.zip'
        },
        {
          name: 'COMOROS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/cn.zip'
        },
        {
          name: 'CONGO',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/cf.zip'
        },
        {
          name: 'CONGO, DEMOCRATIC REPUBLIC OF THE',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/cg.zip'
        },
        {
          name: 'COOK ISLANDS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/cw.zip'
        },
        {
          name: 'CORAL SEA ISLANDS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/cr.zip'
        },
        {
          name: 'COSTA RICA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/cs.zip'
        },
        {
          name: 'CÔTE D\' IVOIRE',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/iv.zip'
        },
        {
          name: 'CROATIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/hr.zip'
        },
        {
          name: 'CUBA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/cu.zip'
        },
        {
          name: 'CURAÇAO',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/uc.zip'
        },
        {
          name: 'CYPRUS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/cy.zip'
        },
        {
          name: 'CZECH REPUBLIC',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ez.zip'
        },
        {
          name: 'DENMARK',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/da.zip'
        },
        {
          name: 'DHEKELIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/dx.zip'
        },
        {
          name: 'DJIBOUTI',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/dj.zip'
        },
        {
          name: 'DOMINICA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/do.zip'
        },
        {
          name: 'DOMINICAN REPUBLIC',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/dr.zip'
        },
        {
          name: 'ECUADOR',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ec.zip'
        },
        {
          name: 'EGYPT',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/eg.zip'
        },
        {
          name: 'EL SALVADOR',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/es.zip'
        },
        {
          name: 'EQUATORIAL GUINEA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ek.zip'
        },
        {
          name: 'ERITREA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/er.zip'
        },
        {
          name: 'ESTONIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/en.zip'
        },
        {
          name: 'ETHIOPIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/et.zip'
        },
        {
          name: 'EUROPA ISLAND',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/eu.zip'
        },
        {
          name: 'FALKLAND ISLANDS (ISLAS MALVINAS)',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/fk.zip'
        },
        {
          name: 'FAROE ISLANDS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/fo.zip'
        },
        {
          name: 'FIJI',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/fj.zip'
        },
        {
          name: 'FINLAND',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/fi.zip'
        },
        {
          name: 'FRANCE',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/fr.zip'
        },
        {
          name: 'FRENCH GUIANA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/fg.zip'
        },
        {
          name: 'FRENCH POLYNESIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/fp.zip'
        },
        {
          name: 'FRENCH SOUTHERN AND ANTARCTIC LANDS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/fs.zip'
        },
        {
          name: 'GABON',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/gb.zip'
        },
        {
          name: 'GAMBIA, THE',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ga.zip'
        },
        {
          name: 'GAZA STRIP',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/gz.zip'
        },
        {
          name: 'GEORGIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/gg.zip'
        },
        {
          name: 'GERMANY',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/gm.zip'
        },
        {
          name: 'GHANA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/gh.zip'
        },
        {
          name: 'GIBRALTAR',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/gi.zip'
        },
        {
          name: 'GLORIOSO ISLANDS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/go.zip'
        },
        {
          name: 'GREECE',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/gr.zip'
        },
        {
          name: 'GREENLAND',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/gl.zip'
        },
        {
          name: 'GRENADA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/gj.zip'
        },
        {
          name: 'GUADELOUPE',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/gp.zip'
        },
        {
          name: 'GUATEMALA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/gt.zip'
        },
        {
          name: 'GUERNSEY',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/gk.zip'
        },
        {
          name: 'GUINEA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/gv.zip'
        },
        {
          name: 'GUINEA-BISSAU',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/pu.zip'
        },
        {
          name: 'GUYANA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/gy.zip'
        },
        {
          name: 'HAITI',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ha.zip'
        },
        {
          name: 'HEARD ISLAND AND MCDONALD ISLANDS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/hm.zip'
        },
        {
          name: 'HONDURAS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ho.zip'
        },
        {
          name: 'HONG KONG',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/hk.zip'
        },
        {
          name: 'HUNGARY',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/hu.zip'
        },
        {
          name: 'ICELAND',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ic.zip'
        },
        {
          name: 'INDIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/in.zip'
        },
        {
          name: 'INDONESIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/id.zip'
        },
        {
          name: 'IRAN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ir.zip'
        },
        {
          name: 'IRAQ',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/iz.zip'
        },
        {
          name: 'IRELAND',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ei.zip'
        },
        {
          name: 'ISLE OF MAN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/im.zip'
        },
        {
          name: 'ISRAEL',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/is.zip'
        },
        {
          name: 'ITALY',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/it.zip'
        },
        {
          name: 'JAMAICA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/jm.zip'
        },
        {
          name: 'JAN MAYEN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/jn.zip'
        },
        {
          name: 'JAPAN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ja.zip'
        },
        {
          name: 'JERSEY',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/je.zip'
        },
        {
          name: 'JORDAN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/jo.zip'
        },
        {
          name: 'JUAN DE NOVA ISLAND',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ju.zip'
        },
        {
          name: 'KAZAKHSTAN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/kz.zip'
        },
        {
          name: 'KENYA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ke.zip'
        },
        {
          name: 'KIRIBATI',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/kr.zip'
        },
        {
          name: 'KOSOVO',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/kv.zip'
        },
        {
          name: 'KUWAIT',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ku.zip'
        },
        {
          name: 'KYRGYZSTAN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/kg.zip'
        },
        {
          name: 'LAOS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/la.zip'
        },
        {
          name: 'LATVIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/lg.zip'
        },
        {
          name: 'LEBANON',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/le.zip'
        },
        {
          name: 'LESOTHO',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/lt.zip'
        },
        {
          name: 'LIBERIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/li.zip'
        },
        {
          name: 'LIBYA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ly.zip'
        },
        {
          name: 'LIECHTENSTEIN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ls.zip'
        },
        {
          name: 'LITHUANIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/lh.zip'
        },
        {
          name: 'LUXEMBOURG',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/lu.zip'
        },
        {
          name: 'MACAU',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/mc.zip'
        },
        {
          name: 'MACEDONIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/mk.zip'
        },
        {
          name: 'MADAGASCAR',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ma.zip'
        },
        {
          name: 'MALAWI',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/mi.zip'
        },
        {
          name: 'MALAYSIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/my.zip'
        },
        {
          name: 'MALDIVES',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/mv.zip'
        },
        {
          name: 'MALI',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ml.zip'
        },
        {
          name: 'MALTA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/mt.zip'
        },
        {
          name: 'MARSHALL ISLANDS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/rm.zip'
        },
        {
          name: 'MARTINIQUE',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/mb.zip'
        },
        {
          name: 'MAURITANIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/mr.zip'
        },
        {
          name: 'MAURITIUS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/mp.zip'
        },
        {
          name: 'MAYOTTE',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/mf.zip'
        },
        {
          name: 'MEXICO',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/mx.zip'
        },
        {
          name: 'MICRONESIA, FEDERATED STATES OF',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/fm.zip'
        },
        {
          name: 'MOLDOVA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/md.zip'
        },
        {
          name: 'MONACO',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/mn.zip'
        },
        {
          name: 'MONGOLIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/mg.zip'
        },
        {
          name: 'MONTENEGRO',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/mj.zip'
        },
        {
          name: 'MONTSERRAT',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/mh.zip'
        },
        {
          name: 'MOROCCO',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/mo.zip'
        },
        {
          name: 'MOZAMBIQUE',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/mz.zip'
        },
        {
          name: 'NAMIBIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/wa.zip'
        },
        {
          name: 'NAURU',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/nr.zip'
        },
        {
          name: 'NEPAL',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/np.zip'
        },
        {
          name: 'NETHERLANDS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/nl.zip'
        },
        {
          name: 'NEW CALEDONIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/nc.zip'
        },
        {
          name: 'NEW ZEALAND',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/nz.zip'
        },
        {
          name: 'NICARAGUA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/nu.zip'
        },
        {
          name: 'NIGER',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ng.zip'
        },
        {
          name: 'NIGERIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ni.zip'
        },
        {
          name: 'NIUE',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ne.zip'
        },
        {
          name: 'NO MAN \'S LAND',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/nm.zip'
        },
        {
          name: 'NORFOLK ISLAND',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/nf.zip'
        },
        {
          name: 'NORTH KOREA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/kn.zip'
        },
        {
          name: 'NORWAY',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/no.zip'
        },
        {
          name: 'OCEANS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/os.zip'
        },
        {
          name: 'OMAN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/mu.zip'
        },
        {
          name: 'PAKISTAN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/pk.zip'
        },
        {
          name: 'PALAU',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ps.zip'
        },
        {
          name: 'PANAMA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/pm.zip'
        },
        {
          name: 'PAPUA NEW GUINEA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/pp.zip'
        },
        {
          name: 'PARACEL ISLANDS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/pf.zip'
        },
        {
          name: 'PARAGUAY',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/pa.zip'
        },
        {
          name: 'PERU',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/pe.zip'
        },
        {
          name: 'PHILIPPINES',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/rp.zip'
        },
        {
          name: 'PITCAIRN ISLANDS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/pc.zip'
        },
        {
          name: 'POLAND',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/pl.zip'
        },
        {
          name: 'PORTUGAL',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/po.zip'
        },
        {
          name: 'QATAR',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/qa.zip'
        },
        {
          name: 'REUNION',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/re.zip'
        },
        {
          name: 'ROMANIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ro.zip'
        },
        {
          name: 'RUSSIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/rs.zip'
        },
        {
          name: 'RWANDA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/rw.zip'
        },
        {
          name: 'SAINT BARTHELEMY',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/tb.zip'
        },
        {
          name: 'SAINT HELENA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/sh.zip'
        },
        {
          name: 'SAINT KITTS AND NEVIS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/sc.zip'
        },
        {
          name: 'SAINT LUCIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/st.zip'
        },
        {
          name: 'SAINT MARTIN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/rn.zip'
        },
        {
          name: 'SAINT PIERRE AND MIQUELON',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/sb.zip'
        },
        {
          name: 'SAINT VINCENT AND THE GRENADINES',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/vc.zip'
        },
        {
          name: 'SAMOA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ws.zip'
        },
        {
          name: 'SAN MARINO',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/sm.zip'
        },
        {
          name: 'SAO TOME AND PRINCIPE',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/tp.zip'
        },
        {
          name: 'SAUDI ARABIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/sa.zip'
        },
        {
          name: 'SENEGAL',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/sg.zip'
        },
        {
          name: 'SERBIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ri.zip'
        },
        {
          name: 'SEYCHELLES',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/se.zip'
        },
        {
          name: 'SIERRA LEONE',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/sl.zip'
        },
        {
          name: 'SINGAPORE',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/sn.zip'
        },
        {
          name: 'SINT MAARTEN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/nn.zip'
        },
        {
          name: 'SLOVAKIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/lo.zip'
        },
        {
          name: 'SLOVENIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/si.zip'
        },
        {
          name: 'SOLOMON ISLANDS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/bp.zip'
        },
        {
          name: 'SOMALIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/so.zip'
        },
        {
          name: 'SOUTH AFRICA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/sf.zip'
        },
        {
          name: 'SOUTH GEORGIA AND SOUTH SANDWICH ISLANDS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/sx.zip'
        },
        {
          name: 'SOUTH KOREA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ks.zip'
        },
        {
          name: 'SOUTH SUDAN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/od.zip'
        },
        {
          name: 'SPAIN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/sp.zip'
        },
        {
          name: 'SPRATLY ISLANDS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/pg.zip'
        },
        {
          name: 'SRI LANKA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ce.zip'
        },
        {
          name: 'SUDAN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/su.zip'
        },
        {
          name: 'SURINAME',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ns.zip'
        },
        {
          name: 'SVALBARD',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/sv.zip'
        },
        {
          name: 'SWAZILAND',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/wz.zip'
        },
        {
          name: 'SWEDEN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/sw.zip'
        },
        {
          name: 'SWITZERLAND',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/sz.zip'
        },
        {
          name: 'SYRIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/sy.zip'
        },
        {
          name: 'TAIWAN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/tw.zip'
        },
        {
          name: 'TAJIKISTAN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ti.zip'
        },
        {
          name: 'TANZANIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/tz.zip'
        },
        {
          name: 'THAILAND',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/th.zip'
        },
        {
          name: 'TIMOR-LESTE',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/tt.zip'
        },
        {
          name: 'TOGO',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/to.zip'
        },
        {
          name: 'TOKELAU',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/tl.zip'
        },
        {
          name: 'TONGA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/tn.zip'
        },
        {
          name: 'TRINIDAD AND TOBAGO',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/td.zip'
        },
        {
          name: 'TROMELIN ISLAND',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/te.zip'
        },
        {
          name: 'TUNISIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ts.zip'
        },
        {
          name: 'TURKEY',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/tu.zip'
        },
        {
          name: 'TURKMENISTAN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/tx.zip'
        },
        {
          name: 'TURKS AND CAICOS ISLANDS',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/tk.zip'
        },
        {
          name: 'TUVALU',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/tv.zip'
        },
        {
          name: 'UGANDA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ug.zip'
        },
        {
          name: 'UKRAINE',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/up.zip'
        },
        {
          name: 'UNDERSEA FEATURES',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/uf.zip'
        },
        {
          name: 'UNITED ARAB EMIRATES',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ae.zip'
        },
        {
          name: 'UNITED KINGDOM',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/uk.zip'
        },
        {
          name: 'URUGUAY',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/uy.zip'
        },
        {
          name: 'UZBEKISTAN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/uz.zip'
        },
        {
          name: 'VANUATU',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/nh.zip'
        },
        {
          name: 'VATICAN CITY',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/vt.zip'
        },
        {
          name: 'VENEZUELA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ve.zip'
        },
        {
          name: 'VIETNAM',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/vm.zip'
        },
        {
          name: 'WALLIS AND FUTUNA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/wf.zip'
        },
        {
          name: 'WEST BANK',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/we.zip'
        },
        {
          name: 'WESTERN SAHARA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/wi.zip'
        },
        {
          name: 'YEMEN',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/ym.zip'
        },
        {
          name: 'ZAMBIA',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/za.zip'
        },
        {
          name: 'ZIMBABWE',
          url: 'http://geonames.nga.mil/gns/html/cntyfile/zi.zip'
        }
      ]

      def download(global_options, options, args)
        SOURCES.pmap do |source|
          download_source(source, global_options.merge(options))
        end
      end

      def extract(global_options, options, args)
        SOURCES.pmap do |source|
          downloaded_file = downloaded_file(source, global_options.merge(options))
          dest_dir = extract_dir(source, global_options.merge(options))

          FileUtils.mkdir_p(dest_dir)

          Zip::ZipFile.open(downloaded_file) do |zip_file|
            # Handle entries one by one
            zip_file.each do |entry|
              # Extract to file/directory/symlink
              puts "Extracting #{entry.name}"
              dest_file = File.join(dest_dir, entry.name.split('/').last)
              FileUtils.rm_rf(dest_file)
              entry.extract(dest_file)
            end
          end
        end
      end

      def transform(global_options, options, args)
        SOURCES.pmap do |source|
          opts = global_options.merge(options)

          extracted_file = extracted_file(source, opts)
          transformed_file = transformed_file(source, opts)

          FileUtils.mkdir_p(transform_dir(source, opts))

          csv_opts = {
            :headers => true,
            :col_sep => "\t",
            :quote_char => "\x00"
          }

          puts "Transforming #{extracted_file}"
          CSV.open(extracted_file, 'r', csv_opts) do |csv|
            headers = %w(
              RC
              UFI
              UNI
              LAT
              LONG
              DMS_LAT
              DMS_LONG
              MGRS
              JOG
              FC
              DSG
              PC
              CC1
              ADM1
              POP
              ELEV
              CC2
              NT
              LC
              SHORT_FORM
              GENERIC
              SORT_NAME_RO
              FULL_NAME_RO
              FULL_NAME_ND_RO
              SORT_NAME_RG
              FULL_NAME_RG
              FULL_NAME_ND_RG
              NOTE
              MODIFY_DATE
              DISPLAY
              NAME_RANK
              NAME_LINK
              TRANSL_CD
              NM_MODIFY_DATE
              F_EFCTV_DT
              F_TERM_DT
            )
            CSV.open(transformed_file, 'w', :write_headers => true, :headers => headers, :quote_char => '"') do |csv_out|
              csv.each do |row|
                csv_out << row
              end
            end
          end
        end
      end

      def load(global_options, options, args)
        opts = global_options.merge(options)
      end

      def extracted_file(source, opts)
        res = super(source, opts)
        res.gsub('.zip', '.txt')
      end

      def transformed_file(source, opts)
        res = super(source, opts)
        res.gsub('.zip', '.txt')
      end
    end
  end
end
