import massive.munit.TestSuite;

import m.cover.coverage.client.CoverageReportClientTest;
import m.cover.coverage.client.EMMAPrintClientTest;
import m.cover.coverage.client.PrintClientTest;
import m.cover.coverage.CoverageExceptionTest;
import m.cover.coverage.CoverageLoggerImplTest;
import m.cover.coverage.CoverageLoggerTest;
import m.cover.coverage.data.AbstractBlockTest;
import m.cover.coverage.data.AbstractNodeListTest;
import m.cover.coverage.data.AbstractNodeTest;
import m.cover.coverage.data.BranchTest;
import m.cover.coverage.data.ClazzTest;
import m.cover.coverage.data.CoverageTest;
import m.cover.coverage.data.DataUtilTest;
import m.cover.coverage.data.FileTest;
import m.cover.coverage.data.MethodTest;
import m.cover.coverage.data.PackageTest;
import m.cover.coverage.data.StatementTest;
import m.cover.coverage.MCoverageTest;
import m.cover.coverage.munit.client.MCoverPrintClientTest;
import m.cover.ExceptionTest;
import m.cover.logger.data.LogRecordingTest;
import m.cover.logger.data.LogTest;
import m.cover.logger.LoggerExceptionTest;
import m.cover.macro.ClassInfoTest;
import m.cover.util.TimerTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(m.cover.coverage.client.CoverageReportClientTest);
		add(m.cover.coverage.client.EMMAPrintClientTest);
		add(m.cover.coverage.client.PrintClientTest);
		add(m.cover.coverage.CoverageExceptionTest);
		add(m.cover.coverage.CoverageLoggerImplTest);
		add(m.cover.coverage.CoverageLoggerTest);
		add(m.cover.coverage.data.AbstractBlockTest);
		add(m.cover.coverage.data.AbstractNodeListTest);
		add(m.cover.coverage.data.AbstractNodeTest);
		add(m.cover.coverage.data.BranchTest);
		add(m.cover.coverage.data.ClazzTest);
		add(m.cover.coverage.data.CoverageTest);
		add(m.cover.coverage.data.DataUtilTest);
		add(m.cover.coverage.data.FileTest);
		add(m.cover.coverage.data.MethodTest);
		add(m.cover.coverage.data.PackageTest);
		add(m.cover.coverage.data.StatementTest);
		add(m.cover.coverage.MCoverageTest);
		add(m.cover.coverage.munit.client.MCoverPrintClientTest);
		add(m.cover.ExceptionTest);
		add(m.cover.logger.data.LogRecordingTest);
		add(m.cover.logger.data.LogTest);
		add(m.cover.logger.LoggerExceptionTest);
		add(m.cover.macro.ClassInfoTest);
		add(m.cover.util.TimerTest);
	}
}
