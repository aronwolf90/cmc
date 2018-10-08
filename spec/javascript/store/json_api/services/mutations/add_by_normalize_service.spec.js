import AddByNormalizeService from '../../../../../../app/javascript/store/json_api/services/mutations/add_by_normalize_service.js'

require('../../../../../mocha')

/* eslint-disable no-undef */

describe('AddByNormalizeService', () => {
  describe('when no data is present in the store and response is an entry', () => {
    def('resource', () => '/post-blocks/2620?include[]=question')
    def('state', () => ({}))
    def('payload', () => ({
      data: {
        'id': '2620',
        'type': 'post-blocks',
        'relationships': {
          'question': {
            'data': {
              'type': 'questions',
              'id': '295'
            }
          }
        },
        'attributes': {
          'text': 'I am great!'
        }
      },
      included: [{
        'type': 'questions',
        'id': '295',
        'attributes': {
          'text': 'How are you?'
        }
      }]
    }))

    def('expectedResult', () => ({
      meta: {
        '/post-blocks/2620': {
          info: {
            include: ['question']
          },
          data: {
            type: 'post-blocks',
            id: '2620'
          }
        }
      },
      'post-blocks': {
        2620: {
          id: '2620',
          type: 'post-blocks',
          attributes: {
            text: 'I am great!'
          },
          relationships: {
            question: {
              data: {
                type: 'questions',
                id: '295'
              }
            }
          }
        }
      },
      questions: {
        295: {
          attributes: {
            text: 'How are you?'
          },
          id: '295',
          type: 'questions'
        }
      }
    }))

    it('insert the data correctly', () => {
      new AddByNormalizeService({
        state: $state,
        payload: $payload,
        resource: $resource
      }).perform()

      expect($state).to.eql($expectedResult)
    })
  })

  describe('when no data is present in the store and response is an array', () => {
    def('resource', () => '/post-blocks?include[]=question')
    def('state', () => ({}))
    def('payload', () => ({
      data: [{
        'id': '2620',
        'type': 'post-blocks',
        'relationships': {
          'question': {
            'data': {
              'type': 'questions',
              'id': '295'
            }
          }
        },
        'attributes': {
          'text': 'I am great!'
        }
      }],
      included: [{
        'type': 'questions',
        'id': '295',
        'attributes': {
          'text': 'How are you?'
        }
      }]
    }))

    def('expectedResult', () => ({
      meta: {
        '/post-blocks': {
          info: {
            include: ['question']
          },
          data: [{
            type: 'post-blocks',
            id: '2620'
          }]
        },
        '/post-blocks/2620': {
          data: {
            type: 'post-blocks',
            id: '2620'
          }
        }
      },
      'post-blocks': {
        2620: {
          id: '2620',
          type: 'post-blocks',
          attributes: {
            text: 'I am great!'
          },
          relationships: {
            question: {
              data: {
                type: 'questions',
                id: '295'
              }
            }
          }
        }
      },
      questions: {
        295: {
          attributes: {
            text: 'How are you?'
          },
          id: '295',
          type: 'questions'
        }
      }
    }))

    it('insert the data correctly', () => {
      new AddByNormalizeService({
        state: $state,
        payload: $payload,
        resource: $resource
      }).perform()

      expect($state).to.eql($expectedResult)
    })
  })
  describe('when data is present in the store and response is an entry', () => {
    def('resource', () => '/post-blocks/2620?include[]=question')
    def('state', () => ({
      'post-blocks': {
        2620: {
          id: '2620',
          type: 'post-blocks'
        },
        2623: {
          id: '2623',
          type: 'post-blocks'
        }
      }
    }))
    def('payload', () => ({
      data: {
        'id': '2620',
        'type': 'post-blocks',
        'relationships': {
          'question': {
            'data': {
              'type': 'questions',
              'id': '295'
            }
          }
        },
        'attributes': {
          'text': 'I am great!'
        }
      },
      included: [{
        'type': 'questions',
        'id': '295',
        'attributes': {
          'text': 'How are you?'
        }
      }]
    }))

    def('expectedResult', () => ({
      meta: {
        '/post-blocks/2620': {
          info: {
            include: ['question']
          },
          data: {
            type: 'post-blocks',
            id: '2620'
          }
        }
      },
      'post-blocks': {
        2620: {
          id: '2620',
          type: 'post-blocks',
          attributes: {
            text: 'I am great!'
          },
          relationships: {
            question: {
              data: {
                type: 'questions',
                id: '295'
              }
            }
          }
        },
        2623: {
          id: '2623',
          type: 'post-blocks'
        }
      },
      questions: {
        295: {
          attributes: {
            text: 'How are you?'
          },
          id: '295',
          type: 'questions'
        }
      }
    }))

    it('insert the data correctly', () => {
      new AddByNormalizeService({
        state: $state,
        payload: $payload,
        resource: $resource
      }).perform()

      expect($state).to.eql($expectedResult)
    })
  })
})
