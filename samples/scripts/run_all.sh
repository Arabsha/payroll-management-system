#!/bin/bash
# Run all Payroll Management System SQL scripts in sequence
# Usage: ./run_all.sh username/password@XE

echo "Starting Payroll Management System Database Setup..."

sqlplus $1 @../sql/01_schema.sql
sqlplus $1 @../sql/02_sample_data.sql
sqlplus $1 @../sql/03_procedures.sql
sqlplus $1 @../sql/04_triggers.sql

echo "✅ All scripts executed successfully!"
