
                    <div styleName={closeDropdown ? "magic-mouse-leave-on" : "magic-mouse-leave-off"} onMouseLeave={this.hideMagicCollapse}></div>

<div styleName="email-option-wrapper" onWheel={preventDefaultOnParentScroll} onMouseLeave={e => e.currentTarget.scrollTop = 0}>
                <ul name="select" styleName="search-type-selector">
                  {this.renderFilter(dropdownValue)}
                  {unSelected.map(option => this.renderFilter(option) )}
                </ul>
              </div>


  private renderFilter = (filterOptions: CombinedFilterField) => {
    const {dropdownValue} = this.state
    return (
      <li value={filterOptions} data-locator={filterOptions} key={filterOptions}>
          <a href="#" aria-label={translate(`dashboard.search.searchFilters.edit.${filterOptions}`)}
            onClick={preventDefault(stopPropagation(() =>
              dropdownValue !== filterOptions
                ? this.handleSelectChange(filterOptions)
                : null
              ))} >
            <Translate content={`dashboard.search.searchFilters.edit.${filterOptions}`} />
          </a>
      </li>
    )
  }
