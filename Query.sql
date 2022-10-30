/*Thống kê số nhân viên mới theo tháng*/
SELECT
  COUNT(Tung_employees.EmpID)
FROM
  Tung_employees
WHERE
  YEAR(startDay) = 2022
  AND MONTH(StartDay) = MONTH(current_date());
  
/*Thống kê số nhân viên mới theo tuần*/
SELECT
  COUNT(Tung_employees.EmpID)
FROM
  Tung_employees
WHERE
  YEAR(startDay) = 2022
  AND MONTH(StartDay) = 7
  AND DAY(StartDay) BETWEEN 20 AND 28;
  
/*Thống kê số tổng số nhân viên*/
SELECT
  COUNT(Tung_employees.EmpID)
FROM
  Tung_employees;

/*Thống kê số nhân viên thử việc*/
SELECT
  COUNT(Tung_contract.EmpID)
FROM
  Tung_contract
WHERE
  ContractStatus = 'Probation';
  
/*Thống kê số nhân viên chính thức*/
SELECT
  COUNT(Tung_contract.EmpID)
FROM
  Tung_contract
WHERE
  ContractStatus = 'Infinity'
  OR ContractStatus = '1 Year';
  
/*Thống kê số nhân viên chính thức*/
SELECT
  COUNT(Tung_contract.EmpID)
FROM
  Tung_contract
WHERE
  NOT ContractStatus = 'Probation';
  
/*Cơ cấu nhân sự theo phòng ban*/
SELECT
  Tung_department.DepName,
  COUNT(Tung_employees.EmpID)
FROM
  Tung_department,
  Tung_employees
WHERE
  Tung_department.DepID = Tung_employees.DepID
GROUP BY
  Tung_department.DepName;
  
/*Cơ cấu nhân sự theo phòng ban đến ngày hiện tại*/
SELECT
  Tung_department.DepName,
  COUNT(Tung_employees.EmpID)
FROM
  Tung_department,
  Tung_employees,
  Tung_contract
WHERE
  Tung_department.DepID = Tung_employees.DepID
  AND Tung_contract.EmpID = Tung_employees.EmpID
  AND Tung_contract.ContractEndDay >= current_date()
GROUP BY
  Tung_department.DepName;
  
/*Cơ cấu nhân sự theo vị trí*/
SELECT
  Tung_role.RoleName,
  COUNT(Tung_employees.EmpID)
FROM
  Tung_role,
  Tung_employees
WHERE
  Tung_role.RoleID = Tung_employees.RoleID
GROUP BY
  Tung_role.RoleName;
  
/*Cơ cấu nhân sự theo vị trí đến ngày hiện tại*/
SELECT
  Tung_role.RoleName,
  COUNT(Tung_employees.EmpID)
FROM
  Tung_role,
  Tung_employees,
  Tung_contract
WHERE
  Tung_role.RoleID = Tung_employees.RoleID
  AND Tung_contract.EmpID = Tung_employees.EmpID
  AND Tung_contract.ContractEndDay >= current_date()
GROUP BY
  Tung_role.RoleName;
  
/*Thống kê hợp đồng theo loại - tất cả đơn vị*/
SELECT
  Tung_contract.ContractStatus,
  COUNT(Tung_contract.EmpID)
FROM
  Tung_contract,
  Tung_employees
WHERE
  Tung_contract.EmpID = Tung_employees.EmpID
GROUP BY
  Tung_contract.ContractStatus;
  
/*Thống kê hợp đồng theo loại - tất cả đơn vị - đến ngày hiện tại*/
SELECT
  Tung_contract.ContractStatus,
  COUNT(Tung_contract.EmpID)
FROM
  Tung_contract,
  Tung_employees
WHERE
  Tung_contract.EmpID = Tung_employees.EmpID
  AND Tung_contract.ContractStartDay =< current_date()
GROUP BY
  Tung_contract.ContractStatus;
  
/*Thống kê hợp đồng theo loại - theo từng đơn vị*/
SELECT
  Tung_contract.ContractStatus,
  Tung_department.DepName,
  COUNT(Tung_contract.EmpID)
FROM
  Tung_contract,
  Tung_employees,
  Tung_department
WHERE
  Tung_contract.EmpID = Tung_employees.EmpID
  AND Tung_department.DepID = Tung_employees.DepID
GROUP BY
  Tung_contract.ContractStatus,
  Tung_department.DepName;
  
/*Thống kê hợp đồng theo loại - theo từng đơn vị - đến ngày hiện tại*/
SELECT
  Tung_contract.ContractStatus,
  Tung_department.DepName,
  COUNT(Tung_contract.EmpID)
FROM
  Tung_contract,
  Tung_employees,
  Tung_department
WHERE
  Tung_contract.EmpID = Tung_employees.EmpID
  AND Tung_department.DepID = Tung_employees.DepID
  AND Tung_contract.ContractStartDay =< current_date()
GROUP BY
  Tung_contract.ContractStatus,
  Tung_department.DepName;
  
/*Biến động nhân sự - đến năm hiện tại*/
SELECT
  YEAR(Tung_contract.ContractStartDay) AS YEARNOW,
  COUNT(
    CASE
      WHEN Tung_contract.ContractEndDay < current_date() then 1
    end
  ) AS EndEmp,
  COUNT(
    CASE
      WHEN Tung_contract.ContractStartDay < current_date() then 1
    end
  ) AS NewEmp
FROM
  Tung_employees,
  Tung_contract
WHERE
  Tung_contract.EmpID = Tung_employees.EmpID
  AND YEAR(Tung_contract.ContractStartDay) < year(current_date())
GROUP BY
  YEAR(Tung_contract.ContractStartDay);
  
/*Biến động nhân sự theo phòng ban - đến năm hiện tại*/
SELECT
  YEAR(Tung_contract.ContractStartDay) AS YEARNOW,
  Tung_department.DepName,
  COUNT(
    CASE
      WHEN Tung_contract.ContractEndDay < current_date() then 1
    end
  ) AS EndEmp,
  COUNT(
    CASE
      WHEN Tung_contract.ContractStartDay < current_date() then 1
    end
  ) AS NewEmp
FROM
  Tung_employees,
  Tung_contract,
  Tung_department
WHERE
  Tung_department.DepID = Tung_employees.DepID
  AND Tung_contract.EmpID = Tung_employees.EmpID
  AND YEAR(Tung_contract.ContractStartDay) < year(current_date())
GROUP BY
  YEAR(Tung_contract.ContractStartDay),
  Tung_department.DepName;
  
/*Biến động nhân sự theo vị trí - đến năm hiện tại*/
SELECT
  YEAR(Tung_contract.ContractStartDay) AS YEARNOW,
  Tung_role.RoleName,
  COUNT(
    CASE
      WHEN Tung_contract.ContractEndDay < current_date() then 1
    end
  ) AS EndEmp,
  COUNT(
    CASE
      WHEN Tung_contract.ContractStartDay < current_date() then 1
    end
  ) AS NewEmp
FROM
  Tung_employees,
  Tung_contract,
  Tung_role
WHERE
  Tung_role.RoleID = Tung_employees.RoleID
  AND Tung_contract.EmpID = Tung_employees.EmpID
  AND YEAR(Tung_contract.ContractStartDay) < year(current_date())
GROUP BY
  YEAR(Tung_contract.ContractStartDay),
  Tung_role.RoleName;
  
/*Tổng chi phí lương cơ bản (Base salary) - Đến ngày hiện tại*/
SELECT
  SUM(Tung_empsalary.BaseSalary)
FROM
  Tung_empsalary;
  
/*Tổng chi phí lương cơ bản (Base salary) theo từng đơn vị - Đến ngày hiện tại*/
SELECT
  Tung_department.DepName,
  SUM(Tung_empsalary.BaseSalary) AS salary
FROM
  Tung_empsalary,
  Tung_employees,
  Tung_department
WHERE
  Tung_empsalary.EmpID = Tung_employees.EmpID
  AND Tung_employees.DepID = Tung_department.DepID
GROUP BY
  Tung_department.DepName;
  
/*Tổng chi phí lương cơ bản (Base salary) theo từng vị trí - Đến ngày hiện tại*/
SELECT
  Tung_role.RoleName,
  SUM(Tung_empsalary.BaseSalary) AS salary
FROM
  Tung_empsalary,
  Tung_employees,
  Tung_role
WHERE
  Tung_empsalary.EmpID = Tung_employees.EmpID
  AND Tung_employees.RoleID = Tung_role.RoleID
GROUP BY
  Tung_role.RoleName;
  
/*Tổng chi phí lương cơ bản (Gross salary) - Đến ngày hiện tại*/
SELECT
  SUM(Tung_empsalary.GrossSalary)
FROM
  Tung_empsalary;
  
/*Tổng chi phí lương cơ bản (Gross salary) theo từng đơn vị - Đến ngày hiện tại*/
SELECT
  Tung_department.DepName,
  SUM(Tung_empsalary.GrossSalary) AS salary
FROM
  Tung_empsalary,
  Tung_employees,
  Tung_department
WHERE
  Tung_empsalary.EmpID = Tung_employees.EmpID
  AND Tung_employees.DepID = Tung_department.DepID
GROUP BY
  Tung_department.DepName;
  
/*Tổng chi phí lương cơ bản (Gross salary) theo từng vị trí - Đến ngày hiện tại*/
SELECT
  Tung_role.RoleName,
  SUM(Tung_empsalary.GrossSalary) AS salary
FROM
  Tung_empsalary,
  Tung_employees,
  Tung_role
WHERE
  Tung_empsalary.EmpID = Tung_employees.EmpID
  AND Tung_employees.RoleID = Tung_role.RoleID
GROUP BY
  Tung_role.RoleName;
  
/*Tổng chi phí lương cơ bản (Net salary) - Đến ngày hiện tại*/
SELECT
  SUM(Tung_empsalary.NetSalary)
FROM
  Tung_empsalary;
  
/*Tổng chi phí lương cơ bản (Net salary) theo từng đơn vị - Đến ngày hiện tại*/
SELECT
  Tung_department.DepName,
  SUM(Tung_empsalary.NetSalary) AS salary
FROM
  Tung_empsalary,
  Tung_employees,
  Tung_department
WHERE
  Tung_empsalary.EmpID = Tung_employees.EmpID
  AND Tung_employees.DepID = Tung_department.DepID
GROUP BY
  Tung_department.DepName;
  
/*Tổng chi phí lương cơ bản (Net salary) theo từng vị trí - Đến ngày hiện tại*/
SELECT
  Tung_role.RoleName,
  SUM(Tung_empsalary.NetSalary) AS salary
FROM
  Tung_empsalary,
  Tung_employees,
  Tung_role
WHERE
  Tung_empsalary.EmpID = Tung_employees.EmpID
  AND Tung_employees.RoleID = Tung_role.RoleID
GROUP BY
  Tung_role.RoleName;
  
/*Thống kê hợp đồng theo loại*/
SELECT
  Tung_contract.ContractStatus,
  count(Tung_contract.EmpID)
FROM
  Tung_contract
GROUP BY
  Tung_contract.ContractStatus;
  
/*Thống kê hợp đồng - sắp hết hạn*/
SELECT
  Tung_contract.ContractStatus,
  count(Tung_contract.EmpID)
FROM
  Tung_contract
WHERE
  datediff(Tung_contract.ContractEndDay, current_date()) < 45
GROUP BY
  Tung_contract.ContractStatus;
  
/*Thống kê hợp đồng hết hạn*/
SELECT
  Tung_contract.ContractStatus,
  count(Tung_contract.EmpID)
FROM
  Tung_contract
WHERE
  datediff(Tung_contract.ContractEndDay, current_date()) > 0
GROUP BY
  Tung_contract.ContractStatus;
  
/*Thống kê nhân viên theo giới tính*/
SELECT
  Tung_employees.Gender,
  count(Tung_employees.EmpID)
FROM
  Tung_employees
GROUP BY
  Tung_employees.Gender;
  
/*Thống kê nhân viên theo độ tuổi*/
SELECT
  count(Tung_employees.EmpID)
FROM
  Tung_employees
WHERE
  ROUND(
    datediff(current_date(), Tung_employees.BirthDay) / 365,
    0
  ) BETWEEN 30 AND 45;
  
/*Thống kê nhân viên theo thâm niên*/
SELECT
  count(Tung_contract.EmpID)
FROM
  Tung_contract
WHERE
  datediff(Tung_contract.ContractEndDay, current_date()) < 0
  AND ROUND(
    datediff(current_date(), Tung_contract.ContractStartDay) / 365,
    0
  ) BETWEEN 0 AND 1;
  
/*Thống kê hợp đồng hết hạn chưa tái kí*/
SELECT
  Tung_contract.ContractStatus,
  count(Tung_contract.EmpID)
FROM
  Tung_contract
WHERE
  datediff(Tung_contract.ContractEndDay, current_date()) > 0
GROUP BY
  Tung_contract.ContractStatus;
  
/*Thống kê nhân viên theo vị trí*/
SELECT
  Tung_department.DepLocation,
  count(Tung_employees.EmpID)
FROM
  Tung_employees,
  Tung_department
WHERE
  Tung_employees.DepID = Tung_department.DepID
GROUP BY
  Tung_department.DepLocation;
  
/*Tổng số dự án*/
SELECT
  count(Tung_projects.ProjectID)
FROM
  Tung_projects;
  
/*Số nhân sự theo từng dự án*/
SELECT
  Tung_projects.ProjectName,
  count(Tung_employees.EmpID)
FROM
  Tung_projects,
  Tung_employees
WHERE
  Tung_projects.ProjectID = Tung_employees.ProjectID
GROUP BY
  Tung_projects.ProjectName;
  
/*Số nhân sự theo từng dự án theo từng vị trí*/
SELECT
  Tung_projects.ProjectName,
  Tung_role.RoleName,
  count(Tung_employees.EmpID)
FROM
  Tung_projects,
  Tung_employees,
  Tung_role
WHERE
  Tung_projects.ProjectID = Tung_employees.ProjectID
  AND Tung_employees.RoleID = Tung_role.RoleID
GROUP BY
  Tung_projects.ProjectName,
  Tung_role.RoleName;
  
/*Tổng chi phí nhân sự (theo lương gross + thưởng) theo từng dự án*/
SELECT
  Tung_projects.ProjectName,
  sum(Tung_empsalary.GrossSalary),
  count(Tung_employees.EmpID)
FROM
  Tung_projects,
  Tung_employees,
  Tung_empsalary
WHERE
  Tung_projects.ProjectID = Tung_employees.ProjectID
  AND Tung_employees.EmpID = Tung_empsalary.EmpID
GROUP BY
  Tung_projects.ProjectName;
  
/*Tổng số nhân sự làm việc Online - theo từng dự án*/
SELECT
  Tung_projects.ProjectName,
  count(Tung_employees.EmpID)
FROM
  Tung_projects,
  Tung_employees,
  Tung_workingmodel
WHERE
  Tung_projects.ProjectID = Tung_employees.ProjectID
  AND Tung_employees.EmpID = Tung_workingmodel.EmpID
  AND Tung_workingmodel.WorkingTime = 'Online'
GROUP BY
  Tung_projects.ProjectName;
  
/*Tổng số nhân sự làm việc Offline - theo từng dự án*/
SELECT
  Tung_projects.ProjectName,
  count(Tung_employees.EmpID)
FROM
  Tung_projects,
  Tung_employees,
  Tung_workingmodel
WHERE
  Tung_projects.ProjectID = Tung_employees.ProjectID
  AND Tung_employees.EmpID = Tung_workingmodel.EmpID
  AND Tung_workingmodel.WorkingTime = 'Offline'
GROUP BY
  Tung_projects.ProjectName;
  
/*Tổng số nhân sự làm việc Hybrid - theo từng dự án*/
SELECT
  Tung_projects.ProjectName,
  count(Tung_employees.EmpID)
FROM
  Tung_projects,
  Tung_employees,
  Tung_workingmodel
WHERE
  Tung_projects.ProjectID = Tung_employees.ProjectID
  AND Tung_employees.EmpID = Tung_workingmodel.EmpID
  AND Tung_workingmodel.WorkingTime = 'Hybrid'
GROUP BY
  Tung_projects.ProjectName;
  
/*Tổng số nhân sự làm việc Full time/Part time*/
SELECT
  Tung_workingmodel.WorkingModel,
  count(Tung_employees.EmpID)
FROM
  Tung_employees,
  Tung_workingmodel
WHERE
  Tung_employees.EmpID = Tung_workingmodel.EmpID
GROUP BY
  Tung_workingmodel.WorkingModel;
  
/*Tổng số nhân viên theo effort */
SELECT
  Tung_workingmodel.Effort,
  count(Tung_employees.EmpID)
FROM
  Tung_employees,
  Tung_workingmodel
WHERE
  Tung_employees.EmpID = Tung_workingmodel.EmpID
GROUP BY
  Tung_workingmodel.Effort;