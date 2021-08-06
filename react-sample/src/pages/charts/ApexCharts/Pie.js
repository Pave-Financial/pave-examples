import React from "react";
import Chart from "react-apexcharts";
import { connect } from "react-redux";
import {map} from 'lodash';
import numeral from 'numeral'

const PieChart = ({ theme, recurringExpenditures  }) => {
  const sourceData = recurringExpenditures ? recurringExpenditures : []
  const data = map(sourceData, (expenditure) => {
    return expenditure.last_amount
  })

  const labels = map(sourceData, (expenditure) => {
    return expenditure.normalized_merchant_name
  })
  const options = {
    dataLabels: {
      enabled: true,
    },
    labels: labels,
    legend: {
      position: 'bottom'
    },
    tooltip: {
        formatter: (val) => numeral(val).format('$0,0.00')
        
    },
    colors: [
      theme.primary,
      theme.success,
      theme.warning,
      theme.danger,
      theme.info
    ]
  };

  return (
    <div className="chart">
      <Chart options={options} series={data} type="donut" height="350" />
    </div>
  );
};

export default connect(store => ({
  theme: store.theme.currentTheme
}))(PieChart);
