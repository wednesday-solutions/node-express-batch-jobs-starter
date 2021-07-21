#!/bin/sh

export ENVIRONMENT_NAME=local
export NODE_ENV=local
export DB_DIALECT=postgres
export DB_NAME=reporting_dashboard_dev
export DB_HOST=localhost
export DB_USERNAME=reporting_dashboard_role
export DB_PASSWORD=password
export DB_PORT=5432

psql -c "CREATE ROLE reporting_dashboard_role LOGIN CREATEDB PASSWORD 'reportingdashboard123';" 
npx sequelize db:create
psql -U admin_dev -c "GRANT ALL PRIVILEGES on DATABASE reporting_dashboard_dev to reporting_dashboard_role;"
psql -c "CREATE DATABASE reporting_dashboard_dev;"

npx sequelize db:drop
npx sequelize db:create
npx sequelize db:migrate
npx sequelize db:seed:all
yarn start:local