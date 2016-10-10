using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Member
/// </summary>
namespace Insus.NET
{
    public class Member
    {
        private string _UserName;
        private string _Email;
        private bool _IsUser;

        public string UserName
        {
            get { return _UserName; }
            set { _UserName = value; }
        }
        public string Email
        {
            get { return _Email; }
            set { _Email = value; }
        }
        public bool IsUser
        {
            get { return _IsUser; }
            set { _IsUser = value; }
        }

        BusinessBase objBusinessBase = new BusinessBase();
        
        public Member()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public DataTable GetAll()
        {
            return objBusinessBase.GetDataToDataSet("usp_Member_GetAll").Tables[0];
        }

        public void Insert()
        {
            Parameter[] parameter = { 
                                        new Parameter ("@UserName",SqlDbType.NVarChar,-1,_UserName),
                                        new Parameter ("@Email",SqlDbType.NVarChar,-1,_Email)
                                    };
            objBusinessBase.ExecuteProcedure("usp_Member_Insert", parameter);
        }

        public void Update()
        { 
             Parameter[] parameter = { 
                                        new Parameter ("@UserName",SqlDbType.NVarChar,-1,_UserName),
                                        new Parameter ("@IsUser",SqlDbType.Bit,1,_IsUser)
                                    };
            objBusinessBase.ExecuteProcedure("usp_Member_Update", parameter);
        }
    }
}