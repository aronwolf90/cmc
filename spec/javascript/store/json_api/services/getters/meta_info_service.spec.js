import MetaInfo from '../../../../../../app/javascript/store/json_api/services/getters/meta_info_service'

/* eslint-disable no-undef */

describe('MetaInfo', () => {
  subject(() => new MetaInfo({ state: $state, name: 'users/1' }))

  def('info', () => ({ page: 1 }))

  describe('when no meta data s present', () => {
    def('state', () => ({ }))

    it('return undefined', () => {
      expect($subject.perform()).to.eql(undefined)
    })
  })

  describe('when the meta is present but not the indicated resource', () => {
    def('state', () => ({ meta: {} }))

    it('return undefined', () => {
      expect($subject.perform()).to.eql(undefined)
    })
  })

  describe('when the meta resource is prsent but not the data field', () => {
    def('state', () => ({ meta: { 'users/1': {} } }))

    it('return undefined', () => {
      expect($subject.perform()).to.eql(undefined)
    })
  })

  describe('when the meta resource is avaiable but not the resource itself', () => {
    def('state', () => ({
      meta: { 'users/1': { info: $info } }
    }))

    it('return undefined', () => {
      expect($subject.perform()).to.eql($info)
    })
  })
})
