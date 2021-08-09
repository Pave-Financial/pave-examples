import async from "../components/Async";

import {
  Sliders as SlidersIcon,
} from "react-feather";

const Pave = async(() => import("../pages/dashboards/Pave"));

const dashboardRoutes = {
  path: "/dashboard",
  name: "Dashboards",
  header: "Pages",
  icon: SlidersIcon,
  containsHome: true,
  children: [
    {
      path: "/",
      name: "Pave",
      component: Pave
    },
  ]
};



// Dashboard specific routes
export const dashboard = [
  dashboardRoutes,
];

// All routes
// eslint-disable-next-line import/no-anonymous-default-export
export default [
  dashboardRoutes,
];
