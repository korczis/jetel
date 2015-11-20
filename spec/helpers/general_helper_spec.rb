# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'jetel/helpers/general_helper'

describe Jetel::Helper do
  describe '#sanitize' do
    it 'Sanitizes spaces' do
      res = Jetel::Helper.sanitize('hello world')
      expect(res).to eql('hello_world')
    end
  end
end