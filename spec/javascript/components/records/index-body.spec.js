import PagesRecordsIndex from 'components/records/index-body'

/* eslint-disable no-undef */
/* eslint-disable no-unused-expressions */

describe('components/records/index-body', () => {
  const relationship = sandbox.stub()
  const factory = ({ monthSpentTime = 0, recordDays = [] }) => {
    return createWrapper(PagesRecordsIndex, {
      propsData: {
        recordDays: recordDays
      },
      mocks: {
        $store: {
          getters: {
            relationship
          }
        }
      }
    })
  }

  it('render record days with records', () => {
    const recordDay = {
      id: '1',
      type: 'record-days',
      attributes: {
        day: '10-10-2020',
        'spent-time': '01:00:00'
      }
    }
    const record = {
      id: '1',
      type: 'records',
      attributes: {
        description: 'Test description',
        'start-time': '2020-10-10T10:00:00.000+01:00',
        'end-time': '2020-10-10T11:00:00.000+01:00'
      },
      meta: {
        permissions: {
          update: true
        }
      }
    }
    relationship.returns([record])
    const wrapper = factory({ recordDays: [recordDay] })

    expect(wrapper.html()).to.include('10-10-2020')
    expect(wrapper.html()).to.include('01:00:00')
    expect(wrapper.html()).to.include('Test description')
    expect(wrapper.html()).to.include('10:00')
    expect(wrapper.html()).to.include('11:00')
    expect(wrapper.html()).to.include('/administration/records/1/edit')
  })
})
